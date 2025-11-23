class LUPrefix {
    private boolean[] uploaded;
    private int longestPrefix;

    public LUPrefix(int n) {
        uploaded = new boolean[n + 1];
        longestPrefix = 0;
    }

    public void upload(int video) {
        uploaded[video] = true;
        while (longestPrefix + 1 < uploaded.length && uploaded[longestPrefix + 1]) {
            longestPrefix++;
        }
    }

    public int longest() {
        return longestPrefix;
    }
}