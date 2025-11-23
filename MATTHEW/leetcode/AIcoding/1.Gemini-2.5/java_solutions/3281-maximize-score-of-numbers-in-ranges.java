import java.util.*;

class Solution {

    static class Range {
        int start;
        int end;
        long score;

        public Range(int start, int end, long score) {
            this.start = start;
            this.end = end;
            this.score = score;
        }
    }

    public long maximizeScore(int[] nums, int[][] ranges, int k) {
        int n = nums.length;
        long[] prefixSum = new long[n + 1];
        for (int i = 0; i < n; i++) {
            prefixSum[i + 1] = prefixSum[i] + nums[i];
        }

        List<Range> scoredRanges = new ArrayList<>();
        for (int[] r : ranges) {
            int s = r[0];
            int e = r[1];
            long currentScore = prefixSum[e + 1] - prefixSum[s];
            scoredRanges.add(new Range(s, e, currentScore));
        }

        Collections.sort(scoredRanges, (a, b) -> {
            if (a.end != b.end) {
                return a.end - b.end;
            }
            return a.start - b.start;
        });

        List<TreeMap<Integer, Long>> dp = new ArrayList<>();

        TreeMap<Integer, Long> dp0 = new TreeMap<>();
        dp0.put(Integer.MIN_VALUE, 0L); 
        dp.add(dp0);

        for (int j = 1; j <= k; j++) {
            TreeMap<Integer, Long> currentDp = new TreeMap<>();
            TreeMap<Integer, Long> prevDp = dp.get(j - 1);

            for (Range r : scoredRanges) {
                Map.Entry<Integer, Long> floorEntry = prevDp.floorEntry(r.start - 1);
                long prevMaxScore = Long.MIN_VALUE / 2; 

                if (floorEntry != null) {
                    prevMaxScore = floorEntry.getValue();
                }

                if (prevMaxScore != Long.MIN_VALUE / 2) {
                    long newScore = r.score + prevMaxScore;

                    Map.Entry<Integer, Long> existingFloor = currentDp.floorEntry(r.end);
                    if (existingFloor != null && existingFloor.getValue() >= newScore) {
                        continue; 
                    }

                    Map.Entry<Integer, Long> higherEntry = currentDp.higherEntry(r.end);
                    while (higherEntry != null && higherEntry.getValue() <= newScore) {
                        currentDp.remove(higherEntry.getKey());
                        higherEntry = currentDp.higherEntry(r.end);
                    }

                    currentDp.put(r.end, newScore);
                }
            }
            dp.add(currentDp);
        }

        long maxOverallScore = Long.MIN_VALUE / 2;
        TreeMap<Integer, Long> finalDp = dp.get(k);

        if (!finalDp.isEmpty()) {
            maxOverallScore = finalDp.lastEntry().getValue();
        }

        return maxOverallScore == Long.MIN_VALUE / 2 ? 0 : maxOverallScore;
    }
}