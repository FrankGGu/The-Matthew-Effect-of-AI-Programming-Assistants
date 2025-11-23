class Solution {
public:
    long long kMirror(int k, int n) {
        long long sum = 0;
        int count = 0;
        long long num = 1;
        while (count < n) {
            if (isMirror(num) && isMirrorInBase(num, k)) {
                sum += num;
                count++;
            }
            num++;
        }
        return sum;
    }

private:
    bool isMirror(long long num) {
        string s = to_string(num);
        int left = 0, right = s.size() - 1;
        while (left < right) {
            if (s[left] != s[right]) {
                return false;
            }
            left++;
            right--;
        }
        return true;
    }

    bool isMirrorInBase(long long num, int k) {
        string s;
        while (num > 0) {
            s += to_string(num % k);
            num /= k;
        }
        int left = 0, right = s.size() - 1;
        while (left < right) {
            if (s[left] != s[right]) {
                return false;
            }
            left++;
            right--;
        }
        return true;
    }
};