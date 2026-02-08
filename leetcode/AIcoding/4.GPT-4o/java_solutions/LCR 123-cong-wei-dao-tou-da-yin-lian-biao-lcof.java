class Solution {
    public int minBooks(int[] books) {
        int n = books.length;
        Arrays.sort(books);
        int count = 0;
        for (int i = 0; i < n; i++) {
            if (i == 0 || books[i] != books[i - 1]) {
                count++;
            }
        }
        return count;
    }
}