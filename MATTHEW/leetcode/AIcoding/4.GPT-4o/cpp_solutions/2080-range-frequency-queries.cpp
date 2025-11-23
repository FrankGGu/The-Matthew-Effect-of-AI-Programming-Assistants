class RangeFreqQuery {
public:
    unordered_map<int, vector<int>> indices;

    RangeFreqQuery(vector<int>& arr) {
        for (int i = 0; i < arr.size(); ++i) {
            indices[arr[i]].push_back(i);
        }
    }

    int query(int left, int right, int value) {
        if (indices.find(value) == indices.end()) return 0;
        const vector<int>& idx = indices[value];
        return upper_bound(idx.begin(), idx.end(), right) - lower_bound(idx.begin(), idx.end(), left);
    }
};