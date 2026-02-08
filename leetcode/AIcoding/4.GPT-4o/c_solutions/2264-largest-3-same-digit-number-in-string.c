int largestGoodInteger(char * num) {
    int maxNum = -1;
    for (int i = 0; num[i] != '\0'; i++) {
        if (num[i] == num[i+1] && num[i] == num[i+2]) {
            int currentNum = (num[i] - '0') * 100 + (num[i] - '0') * 10 + (num[i] - '0');
            if (currentNum > maxNum) {
                maxNum = currentNum;
            }
        }
    }
    return maxNum == -1 ? 0 : maxNum;
}