class Solution {
    public int smallestChair(int[][] times, int targetFriend) {
        int n = times.length;
        int[][] chairs = new int[n][2];
        for (int i = 0; i < n; i++) {
            chairs[i][0] = times[i][0];
            chairs[i][1] = times[i][1];
        }
        Arrays.sort(chairs, Comparator.comparingInt(a -> a[0]));

        PriorityQueue<Integer> freeChairs = new PriorityQueue<>();
        for (int i = 0; i < n; i++) {
            freeChairs.offer(i);
        }

        PriorityQueue<int[]> busyChairs = new PriorityQueue<>(Comparator.comparingInt(a -> a[0]));

        for (int[] chair : chairs) {
            while (!busyChairs.isEmpty() && busyChairs.peek()[0] <= chair[0]) {
                freeChairs.offer(busyChairs.poll()[1]);
            }
            int chairIndex = freeChairs.poll();
            busyChairs.offer(new int[]{chair[1], chairIndex});
            if (chair[0] == times[targetFriend][0] && chair[1] == times[targetFriend][1]) {
                return chairIndex;
            }
        }

        return -1;
    }
}