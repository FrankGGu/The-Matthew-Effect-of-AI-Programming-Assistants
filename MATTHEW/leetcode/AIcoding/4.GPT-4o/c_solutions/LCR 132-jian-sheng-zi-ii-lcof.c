int cut(vector<int> &A, int k) {
    long long low = 1, high = *max_element(A.begin(), A.end()), ans = 0;

    while (low <= high) {
        long long mid = low + (high - low) / 2;
        long long sum = 0;

        for (int height : A) {
            if (height > mid) {
                sum += height - mid;
            }
        }

        if (sum >= k) {
            ans = mid;
            low = mid + 1;
        } else {
            high = mid - 1;
        }
    }

    return ans;
}