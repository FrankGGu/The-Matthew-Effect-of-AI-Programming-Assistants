class RLEIterator {
public:
    vector<int> arr;
    int idx;
    RLEIterator(vector<int>& A) : arr(A), idx(0) {}

    int next(int n) {
        while (idx < arr.size()) {
            if (n <= arr[idx]) {
                arr[idx] -= n;
                return arr[idx + 1];
            }
            n -= arr[idx];
            idx += 2;
        }
        return -1;
    }
};