class Solution {
    public int monkeyCollisions(String directions) {
        int count = 0;
        int n = directions.length();
        char[] arr = directions.toCharArray();

        for (int i = 0; i < n; i++) {
            if (arr[i] == 'R') {
                for (int j = i + 1; j < n; j++) {
                    if (arr[j] == 'L') {
                        count += j - i;
                        break;
                    } else if (arr[j] == 'S') {
                        count += j - i;
                    }
                }
            } else if (arr[i] == 'L') {
                for (int j = i - 1; j >= 0; j--) {
                    if (arr[j] == 'R') {
                        count += i - j;
                        break;
                    } else if (arr[j] == 'S') {
                        count += i - j;
                    }
                }
            }
        }

        return count;
    }
}