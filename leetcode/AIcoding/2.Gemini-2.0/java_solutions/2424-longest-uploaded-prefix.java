class Solution {
    public int longestUploadedPrefix(int[] videos) {
        int n = videos.length;
        boolean[] uploaded = new boolean[n + 1];
        int count = 0;
        for (int video : videos) {
            uploaded[video] = true;
            while (count + 1 <= n && uploaded[count + 1]) {
                count++;
            }
        }
        return count;
    }
}