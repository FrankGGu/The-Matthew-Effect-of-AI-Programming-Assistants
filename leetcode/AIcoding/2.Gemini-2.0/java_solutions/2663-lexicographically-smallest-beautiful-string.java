class Solution {
    public String smallestBeautifulString(String s, int k) {
        char[] arr = s.toCharArray();
        int n = arr.length;

        for (int i = n - 1; i >= 0; i--) {
            char c = arr[i];
            while (c < 'a' + k - 1) {
                c++;
                if ((i > 0 && c == arr[i - 1]) || (i > 1 && c == arr[i - 2])) {
                    continue;
                }
                arr[i] = c;
                for (int j = i + 1; j < n; j++) {
                    char next = 'a';
                    while ((j > 0 && next == arr[j - 1]) || (j > 1 && next == arr[j - 2])) {
                        next++;
                    }
                    if (next >= 'a' + k) return null;
                    arr[j] = next;
                }
                return new String(arr);
            }
        }
        return null;
    }
}