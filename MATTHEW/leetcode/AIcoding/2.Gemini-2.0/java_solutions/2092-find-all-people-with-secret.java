import java.util.*;

class Solution {
    public List<Integer> findAllPeople(int n, int[][] meetings, int firstPerson) {
        List<Integer> known = new ArrayList<>();
        known.add(0);
        known.add(firstPerson);

        Arrays.sort(meetings, (a, b) -> a[2] - b[2]);

        int i = 0;
        while (i < meetings.length) {
            int time = meetings[i][2];
            Set<Integer> people = new HashSet<>();
            List<int[]> currentMeetings = new ArrayList<>();

            while (i < meetings.length && meetings[i][2] == time) {
                people.add(meetings[i][0]);
                people.add(meetings[i][1]);
                currentMeetings.add(meetings[i]);
                i++;
            }

            Map<Integer, List<Integer>> adj = new HashMap<>();
            for (int p : people) {
                adj.put(p, new ArrayList<>());
            }

            for (int[] meeting : currentMeetings) {
                adj.get(meeting[0]).add(meeting[1]);
                adj.get(meeting[1]).add(meeting[0]);
            }

            Queue<Integer> q = new LinkedList<>();
            for (int p : people) {
                if (known.contains(p)) {
                    q.offer(p);
                }
            }

            Set<Integer> newlyKnown = new HashSet<>();
            while (!q.isEmpty()) {
                int curr = q.poll();
                if (newlyKnown.contains(curr)) continue;
                newlyKnown.add(curr);

                for (int neighbor : adj.get(curr)) {
                    if (!newlyKnown.contains(neighbor)) {
                        q.offer(neighbor);
                    }
                }
            }

            for (int p : newlyKnown) {
                if (!known.contains(p)) {
                    known.add(p);
                }
            }
        }

        Collections.sort(known);
        return known;
    }
}