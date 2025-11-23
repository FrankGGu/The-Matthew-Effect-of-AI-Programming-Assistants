class LUPrefix {
    private boolean[] uploaded;
    private int longestPrefix;

    public LUPrefix(int n) {
        uploaded = new boolean[n + 2];
        longestPrefix = 0;
    }

    public void upload(int video) {
        uploaded[video] = true;
        while (uploaded[longestPrefix + 1]) {
            longestPrefix++;
        }
    }

    public int longest() {
        return longestPrefix;
    }
}