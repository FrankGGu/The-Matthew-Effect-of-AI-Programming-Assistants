public class Solution {
    public int meetPeople(int[] people, int k) {
        int n = people.length;
        int[] dist = new int[n];
        for (int i = 0; i < n; i++) {
            if (people[i] == 1) {
                dist[i] = 0;
            } else {
                dist[i] = Integer.MAX_VALUE;
            }
        }
        for (int i = 0; i < n; i++) {
            if (people[i] == 1) {
                for (int j = i + 1; j < n && j - i <= k; j++) {
                    if (people[j] == 0) {
                        dist[j] = Math.min(dist[j], j - i);
                    }
                }
            }
        }
        for (int i = n - 1; i >= 0; i--) {
            if (people[i] == 1) {
                for (int j = i - 1; j >= 0 && i - j <= k; j--) {
                    if (people[j] == 0) {
                        dist[j] = Math.min(dist[j], i - j);
                    }
                }
            }
        }
        int minDist = Integer.MAX_VALUE;
        for (int i = 0; i < n; i++) {
            if (people[i] == 0) {
                minDist = Math.min(minDist, dist[i]);
            }
        }
        return minDist;
    }
}