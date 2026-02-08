class Solution {
public:
    int nextGreaterElement(int n) {
        string num = to_string(n);
        int len = num.size();
        int i = len - 2;

        while (i >= 0 && num[i] >= num[i + 1]) {
            i--;
        }

        if (i < 0) return -1;

        int j = len - 1;
        while (num[j] <= num[i]) {
            j--;
        }

        swap(num[i], num[j]);
        reverse(num.begin() + i + 1, num.end());

        long long res = stoll(num);
        return (res > INT_MAX) ? -1 : res;
    }
};