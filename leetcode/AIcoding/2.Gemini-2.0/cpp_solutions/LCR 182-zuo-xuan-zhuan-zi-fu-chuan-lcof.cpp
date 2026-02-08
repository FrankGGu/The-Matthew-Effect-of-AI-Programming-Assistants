#include <string>
#include <vector>

using namespace std;

class Solution {
public:
    int strongPasswordChecker(string password) {
        int n = password.length();
        int missingTypes = 3;
        bool hasLower = false, hasUpper = false, hasDigit = false;
        for (char c : password) {
            if (islower(c)) hasLower = true;
            else if (isupper(c)) hasUpper = true;
            else if (isdigit(c)) hasDigit = true;
        }
        if (hasLower) missingTypes--;
        if (hasUpper) missingTypes--;
        if (hasDigit) missingTypes--;

        int changes = 0;
        vector<int> repeats;
        for (int i = 0; i < n;) {
            int j = i;
            while (j < n && password[j] == password[i]) j++;
            int len = j - i;
            if (len >= 3) repeats.push_back(len);
            i = j;
        }

        if (n < 6) {
            changes += max(missingTypes, 6 - n);
        } else if (n > 20) {
            int overLength = n - 20;
            changes += overLength;
            sort(repeats.begin(), repeats.end());
            for (int i = 0; i < repeats.size(); i++) {
                if (repeats[i] < 3) continue;
                int needDelete = min(overLength, (repeats[i] - 2) % 3 + 1);
                repeats[i] -= needDelete;
                overLength -= needDelete;
                changes -= needDelete;
            }
            for (int i = 0; i < repeats.size(); i++) {
                if (repeats[i] < 3) continue;
                int needDelete = min(overLength, repeats[i] / 3);
                repeats[i] -= needDelete * 3;
                overLength -= needDelete;
                changes -= needDelete;
            }
        } else {
            for (int len : repeats) {
                changes += len / 3;
            }
            changes = max(changes, missingTypes);
        }

        return changes;
    }
};