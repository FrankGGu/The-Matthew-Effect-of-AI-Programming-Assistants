class Solution {
    public String modifyString(String s) {
        char[] arr = s.toCharArray();
        int n = arr.length;

        for (int i = 0; i < n; i++) {
            if (arr[i] == '?') {
                for (char ch = 'a'; ch <= 'c'; ch++) {
                    boolean conflict = false;

                    // Check left neighbor
                    if (i > 0 && arr[i - 1] == ch) {
                        conflict = true;
                    }

                    // Check right neighbor
                    // Only check if arr[i+1] is not '?' because if it is, it will be replaced later
                    // to avoid arr[i]. If arr[i+1] is a fixed character, it imposes a restriction.
                    if (i < n - 1 && arr[i + 1] != '?' && arr[i + 1] == ch) {
                        conflict = true;
                    }

                    if (!conflict) {
                        arr[i] = ch;
                        break;
                    }
                }
            }
        }

        return new String(arr);
    }
}