class SummaryRanges {
private:
    set<int> nums;

public:
    SummaryRanges() {
    }

    void addNum(int value) {
        nums.insert(value);
    }

    vector<vector<int>> getIntervals() {
        vector<vector<int>> res;
        if (nums.empty()) {
            return res;
        }
        int start = *nums.begin();
        int end = *nums.begin();
        for (auto it = next(nums.begin()); it != nums.end(); ++it) {
            if (*it == end + 1) {
                end = *it;
            } else {
                res.push_back({start, end});
                start = end = *it;
            }
        }
        res.push_back({start, end});
        return res;
    }
};