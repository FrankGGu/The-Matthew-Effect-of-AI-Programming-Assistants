class TopVotedCandidate {
    private int[] times;
    private int[] leaders;

    public TopVotedCandidate(int[] persons, int[] times) {
        this.times = times;
        this.leaders = new int[times.length];
        int[] count = new int[persons.length + 1];
        int leader = persons[0];
        for (int i = 0; i < persons.length; i++) {
            count[persons[i]]++;
            if (count[persons[i]] >= count[leader]) {
                leader = persons[i];
            }
            leaders[i] = leader;
        }
    }

    public int q(int t) {
        int left = 0, right = times.length - 1;
        while (left <= right) {
            int mid = left + (right - left) / 2;
            if (times[mid] == t) {
                return leaders[mid];
            } else if (times[mid] < t) {
                left = mid + 1;
            } else {
                right = mid - 1;
            }
        }
        return leaders[right];
    }
}