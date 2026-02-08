class Solution {
    public int numberOfWays(String corridor) {
        long mod = 1000000007;
        int seats = 0;
        for (char c : corridor.toCharArray()) {
            if (c == 'S') {
                seats++;
            }
        }
        if (seats == 0 || seats % 2 != 0) {
            return 0;
        }

        long ways = 1;
        int first = -1;
        for (int i = 0; i < corridor.length(); i++) {
            if (corridor.charAt(i) == 'S') {
                if (first == -1) {
                    first = i;
                } else {
                    first = -1;
                    int j = i + 1;
                    while (j < corridor.length() && corridor.charAt(j) != 'S') {
                        j++;
                    }
                    if (j < corridor.length()) {
                        ways = (ways * (j - i)) % mod;
                    }
                }
            }
        }
        return (int) ways;
    }
}