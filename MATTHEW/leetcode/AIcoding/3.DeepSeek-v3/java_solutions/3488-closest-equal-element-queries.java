class Solution {
    public int[] closestEqualElements(int[] arr, int[][] queries) {
        Map<Integer, List<Integer>> map = new HashMap<>();
        for (int i = 0; i < arr.length; i++) {
            map.computeIfAbsent(arr[i], k -> new ArrayList<>()).add(i);
        }

        int[] result = new int[queries.length];
        for (int i = 0; i < queries.length; i++) {
            int idx = queries[i][0];
            int target = arr[idx];
            List<Integer> indices = map.get(target);
            int res = binarySearch(indices, idx);
            result[i] = res;
        }
        return result;
    }

    private int binarySearch(List<Integer> indices, int idx) {
        int left = 0, right = indices.size() - 1;
        int res = -1;
        while (left <= right) {
            int mid = left + (right - left) / 2;
            if (indices.get(mid) == idx) {
                res = indices.get(mid);
                break;
            } else if (indices.get(mid) < idx) {
                left = mid + 1;
            } else {
                right = mid - 1;
            }
        }

        if (res != -1) {
            int minDist = Integer.MAX_VALUE;
            int bestIdx = -1;
            if (mid - 1 >= 0) {
                int dist = Math.abs(indices.get(mid - 1) - idx);
                if (dist < minDist) {
                    minDist = dist;
                    bestIdx = indices.get(mid - 1);
                }
            }
            if (mid + 1 < indices.size()) {
                int dist = Math.abs(indices.get(mid + 1) - idx);
                if (dist < minDist) {
                    minDist = dist;
                    bestIdx = indices.get(mid + 1);
                } else if (dist == minDist) {
                    bestIdx = Math.min(bestIdx, indices.get(mid + 1));
                }
            }
            return bestIdx;
        }

        if (left == 0) {
            return indices.get(left);
        } else if (left == indices.size()) {
            return indices.get(left - 1);
        } else {
            int distLeft = Math.abs(indices.get(left - 1) - idx);
            int distRight = Math.abs(indices.get(left) - idx);
            if (distLeft < distRight) {
                return indices.get(left - 1);
            } else if (distLeft > distRight) {
                return indices.get(left);
            } else {
                return Math.min(indices.get(left - 1), indices.get(left));
            }
        }
    }
}