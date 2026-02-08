class MajorityChecker {
public:
    vector<int> arr;
    unordered_map<int, vector<int>> indices;

    MajorityChecker(vector<int>& arr) {
        this->arr = arr;
        for (int i = 0; i < arr.size(); ++i) {
            indices[arr[i]].push_back(i);
        }
    }

    int query(int left, int right, int threshold) {
        for (int i = 0; i < 20; ++i) {
            int randomIndex = left + rand() % (right - left + 1);
            int candidate = arr[randomIndex];
            int count = upper_bound(indices[candidate].begin(), indices[candidate].end(), right) - 
                        lower_bound(indices[candidate].begin(), indices[candidate].end(), left);
            if (count >= threshold) {
                return candidate;
            }
        }
        return -1;
    }
};