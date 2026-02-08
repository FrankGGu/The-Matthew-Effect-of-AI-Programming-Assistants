class RangeFreqQuery {
public:
    RangeFreqQuery(vector<int>& arr) : arr_(arr) {}

    int query(int left, int right, int value) {
        int count = 0;
        for (int i = left; i <= right; ++i) {
            if (arr_[i] == value) {
                count++;
            }
        }
        return count;
    }

private:
    vector<int> arr_;
};