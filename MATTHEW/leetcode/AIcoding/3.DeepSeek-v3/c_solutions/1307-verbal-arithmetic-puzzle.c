bool backtrack(char** words, int wordsSize, char* result, int* charToDigit, bool* usedDigit, int* power, int* charIndex, int charCount, int pos, int carry) {
    if (pos == charCount) {
        return carry == 0;
    }

    int ch = charIndex[pos];
    int sum = carry;

    for (int i = 0; i < wordsSize; i++) {
        char* word = words[i];
        int len = strlen(word);
        for (int j = 0; j < len; j++) {
            if (word[j] == ch + 'A') {
                sum += power[len - j - 1];
            }
        }
    }

    int digit = sum % 10;
    carry = sum / 10;

    if (charToDigit[ch] != -1) {
        if (charToDigit[ch] != digit) {
            return false;
        }
        return backtrack(words, wordsSize, result, charToDigit, usedDigit, power, charIndex, charCount, pos + 1, carry);
    }

    for (int d = 0; d <= 9; d++) {
        if (!usedDigit[d]) {
            if (d == 0) {
                int cannotBeZero = 0;
                for (int i = 0; i < wordsSize; i++) {
                    if (words[i][0] == ch + 'A') {
                        cannotBeZero = 1;
                        break;
                    }
                }
                if (result[0] == ch + 'A') {
                    cannotBeZero = 1;
                }
                if (cannotBeZero) {
                    continue;
                }
            }
            usedDigit[d] = true;
            charToDigit[ch] = d;
            if (backtrack(words, wordsSize, result, charToDigit, usedDigit, power, charIndex, charCount, pos + 1, carry)) {
                return true;
            }
            charToDigit[ch] = -1;
            usedDigit[d] = false;
        }
    }
    return false;
}

bool isSolvable(char** words, int wordsSize, char* result) {
    int maxLen = 0;
    for (int i = 0; i < wordsSize; i++) {
        int len = strlen(words[i]);
        if (len > maxLen) maxLen = len;
    }
    int resLen = strlen(result);
    if (resLen < maxLen || resLen > maxLen + 1) return false;

    bool present[26] = {false};
    for (int i = 0; i < wordsSize; i++) {
        for (char* p = words[i]; *p; p++) {
            present[*p - 'A'] = true;
        }
    }
    for (char* p = result; *p; p++) {
        present[*p - 'A'] = true;
    }

    int charCount = 0;
    int charIndex[26];
    for (int i = 0; i < 26; i++) {
        if (present[i]) {
            charIndex[charCount++] = i;
        }
    }

    int* power = (int*)malloc((maxLen + 1) * sizeof(int));
    power[0] = 1;
    for (int i = 1; i <= maxLen; i++) {
        power[i] = power[i-1] * 10;
    }

    int charToDigit[26];
    for (int i = 0; i < 26; i++) {
        charToDigit[i] = -1;
    }
    bool usedDigit[10] = {false};

    bool ret = backtrack(words, wordsSize, result, charToDigit, usedDigit, power, charIndex, charCount, 0, 0);
    free(power);
    return ret;
}