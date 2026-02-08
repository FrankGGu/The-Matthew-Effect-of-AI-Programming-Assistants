class Solution {
    public String smallestBeautifulString(String s, int k) {
        char[] arr = s.toCharArray();
        int n = arr.length;

        for (int i = n - 1; i >= 0; i--) {
            arr[i]++;
            while (arr[i] - 'a' >= k || (i > 0 && arr[i] == arr[i - 1]) || (i > 1 && arr[i] == arr[i - 2])) {
                arr[i]++;
            }
            if (arr[i] - 'a' < k) {
                break;
            }
            arr[i] = 'a';
        }

        if (arr[0] - 'a' >= k) {
            return "";
        }

        return new String(arr);
    }
}