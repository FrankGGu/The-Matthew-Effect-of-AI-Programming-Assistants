import java.util.*;

class Solution {

    static class FenwickTree {
        int[] bit;
        int size;

        public FenwickTree(int size) {
            this.size = size;
            bit = new int[size + 1];
        }

        public void update(int idx, int delta) {
            idx++; 
            while (idx <= size) {
                bit[idx] += delta;
                idx += idx & (-idx);
            }
        }

        public int query(int idx) {
            idx++; 
            int sum = 0;
            while (idx > 0) {
                sum += bit[idx];
                idx -= idx & (-idx);
            }
            return sum;
        }
    }

    static class PointUV {
        long u;
        int v;

        public PointUV(long u, int v) {
            this.u = u;
            this.v = v;
        }
    }

    private boolean check(long D, PointUV[] points_uv_original, int k) {
        int n = points_uv_original.length;
        if (n - k <= 1) {
            return true;
        }

        PointUV[] points_uv = new PointUV[n];
        for(int i=0; i<n; ++i) {
            points_uv[i] = points_uv_original[i];
        }

        List<Integer> v_coords = new ArrayList<>();
        for (PointUV p : points_uv) {
            v_coords.add(p.v);
        }
        Collections.sort(v_coords);

        List<Integer> unique_v_coords = new ArrayList<>();
        if (!v_coords.isEmpty()) {
            unique_v_coords.add(v_coords.get(0));
            for (int i = 1; i < v_coords.size(); i++) {
                if (!v_coords.get(i).equals(v_coords.get(i - 1))) {
                    unique_v_coords.add(v_coords.get(i));
                }
            }
        }

        Map<Integer, Integer> v_to_idx = new HashMap<>();
        for (int i = 0; i < unique_v_coords.size(); i++) {
            v_to_idx.put(unique_v_coords.get(i), i);
        }

        Arrays.sort(points_uv, (a, b) -> Long.compare(a.u, b.u));

        FenwickTree ft = new FenwickTree(unique_v_coords.size());

        int left = 0;
        int required_points = n - k;

        for (int right = 0; right < n; right++) {
            ft.update(v_to_idx.get(points_uv[right].v), 1);

            while (points_uv[right].u - points_uv[left].u > D) {
                ft.update(v_to_idx.get(points_uv[left].v), -1);
                left++;
            }

            if (right - left + 1 < required_points) {
                continue;
            }

            int current_max_v_count = 0;
            for (int v_start_idx = 0; v_start_idx < unique_v_coords.size(); v_start_idx++) {
                int v_start_val = unique_v_coords.get(v_start_idx);
                long v_end_val_limit = v_start_val + D;

                int v_end_idx = Collections.binarySearch(unique_v_coords, (int) v_end_val_limit);
                if (v_end_idx < 0) {
                    v_end_idx = -v_end_idx - 2;
                }
                v_end_idx = Math.min(v_end_idx, unique_v_coords.size() - 1);

                if (v_end_idx < v_start_idx) {
                    continue;
                }

                int count = ft.query(v_end_idx) - (v_start_idx > 0 ? ft.query(v_start_idx - 1) : 0);
                current_max_v_count = Math.max(current_max_v_count, count);

                if (current_max_v_count >= required_points) {
                    break;
                }
            }

            if (current_max_v_count >= required_points) {
                return true;
            }
        }

        return false;
    }

    public long maxManhattanDistance(int[][] points, int k) {
        int n = points.length;
        if (n == 0) return 0;

        PointUV[] points_uv = new PointUV[n];
        for (int i = 0; i < n; i++) {
            points_uv[i] = new PointUV((long) points[i][0] + points[i][1], points[i][0] - points[i][1]);
        }

        long low = 0;
        long high = 4_000_000_000L; 
        long ans = 0;

        while (low <= high) {
            long mid = low + (high - low) / 2;
            if (check(mid, points_uv, k)) {
                ans = mid;
                high = mid - 1;
            } else {
                low = mid + 1;
            }
        }

        return ans;
    }
}