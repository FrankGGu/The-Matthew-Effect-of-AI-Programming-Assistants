class Solution {
    public int magicalString(int n) {
        if (n == 0) return 0;
        if (n <= 3) return 1;

        int[] magic = new int[n];
        magic[0] = 1;
        magic[1] = 2;
        magic[2] = 2;

        int count = 1, idx = 2, nextIdx = 3;
        while (nextIdx < n) {
            int num = magic[idx++];
            for (int i = 0; i < num && nextIdx < n; i++) {
                magic[nextIdx++] = (count % 2) + 1;
                if (magic[nextIdx - 1] == 1) count++;
            }
        }

        int result = 0;
        for (int i = 0; i < n; i++) {
            if (magic[i] == 1) result++;
        }

        return result;
    }
}