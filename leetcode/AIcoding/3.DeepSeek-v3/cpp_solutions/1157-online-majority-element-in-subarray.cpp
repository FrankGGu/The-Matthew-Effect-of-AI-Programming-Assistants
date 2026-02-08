class MajorityChecker {
private:
    unordered_map<int, vector<int>> indices;
    vector<int> a;
    vector<vector<int>> segmentTree;
    int n;

    void build(int node, int l, int r) {
        if (l == r) {
            segmentTree[node] = {a[l]};
            return;
        }
        int mid = (l + r) / 2;
        build(2 * node + 1, l, mid);
        build(2 * node + 2, mid + 1, r);
        segmentTree[node] = merge(segmentTree[2 * node + 1], segmentTree[2 * node + 2]);
    }

    vector<int> merge(vector<int>& left, vector<int>& right) {
        vector<int> res;
        int i = 0, j = 0;
        while (i < left.size() && j < right.size()) {
            if (left[i] < right[j]) {
                res.push_back(left[i++]);
            } else {
                res.push_back(right[j++]);
            }
        }
        while (i < left.size()) res.push_back(left[i++]);
        while (j < right.size()) res.push_back(right[j++]);
        return res;
    }

    int queryCount(int node, int l, int r, int ql, int qr, int val) {
        if (qr < l || ql > r) return 0;
        if (ql <= l && r <= qr) {
            auto& v = segmentTree[node];
            auto it1 = lower_bound(v.begin(), v.end(), val);
            auto it2 = upper_bound(v.begin(), v.end(), val);
            return it2 - it1;
        }
        int mid = (l + r) / 2;
        return queryCount(2 * node + 1, l, mid, ql, qr, val) + 
               queryCount(2 * node + 2, mid + 1, r, ql, qr, val);
    }

public:
    MajorityChecker(vector<int>& arr) {
        a = arr;
        n = arr.size();
        for (int i = 0; i < n; ++i) {
            indices[arr[i]].push_back(i);
        }
        int size = 1;
        while (size < n) size <<= 1;
        segmentTree.resize(2 * size);
        build(0, 0, n - 1);
    }

    int query(int left, int right, int threshold) {
        int len = right - left + 1;
        for (int i = 0; i < 20; ++i) {
            int idx = left + rand() % len;
            int val = a[idx];
            auto& v = indices[val];
            auto l = lower_bound(v.begin(), v.end(), left);
            auto r = upper_bound(v.begin(), v.end(), right);
            int cnt = r - l;
            if (cnt >= threshold) {
                return val;
            }
        }
        return -1;
    }
};