class Solution {
public:
    int strongPasswordChecker(string password) {
        int n = password.size();
        bool has_lower = false, has_upper = false, has_digit = false;
        for (char c : password) {
            if (islower(c)) has_lower = true;
            else if (isupper(c)) has_upper = true;
            else if (isdigit(c)) has_digit = true;
        }
        int missing_types = 3 - (has_lower + has_upper + has_digit);

        int replace = 0;
        int one_seq = 0, two_seq = 0;
        for (int i = 2; i < n;) {
            if (password[i] == password[i-1] && password[i-1] == password[i-2]) {
                int length = 2;
                while (i < n && password[i] == password[i-1]) {
                    length++;
                    i++;
                }
                replace += length / 3;
                if (length % 3 == 0) one_seq++;
                else if (length % 3 == 1) two_seq++;
            } else {
                i++;
            }
        }

        if (n < 6) {
            return max(max(6 - n, missing_types), replace);
        } else if (n <= 20) {
            return max(missing_types, replace);
        } else {
            int delete_count = n - 20;
            replace -= min(delete_count, one_seq * 1) / 1;
            replace -= min(max(delete_count - one_seq, 0), two_seq * 2) / 2;
            replace -= max(delete_count - one_seq - two_seq * 2, 0) / 3;
            return delete_count + max(missing_types, replace);
        }
    }
};