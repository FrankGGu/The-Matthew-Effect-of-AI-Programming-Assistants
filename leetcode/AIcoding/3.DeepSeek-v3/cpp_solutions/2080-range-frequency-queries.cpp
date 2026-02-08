class RangeFreqQuery {
private:
    unordered_map<int, vector<int>> valueIndices;

public:
    RangeFreqQuery(vector<int>& arr) {
        for (int i = 0; i < arr.size(); ++i) {
            valueIndices[arr[i]].push_back(i);
        }
    }

    int query(int left, int right, int value) {
        if (valueIndices.find(value) == valueIndices.end()) {
            return 0;
        }
        const vector<int>& indices = valueIndices[value];
        auto leftIt = lower_bound(indices.begin(), indices.end(), left);
        auto rightIt = upper_bound(indices.begin(), indices.end(), right);
        return rightIt - leftIt;
    }
};