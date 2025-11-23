public class Solution {

import java.util.*;

public class Solution {
    public List<Integer> minHammingNoSwap(int[] target, int[] arr) {
        List<Integer> result = new ArrayList<>();
        int n = target.length;
        boolean[] used = new boolean[n];
        for (int i = 0; i < n; i++) {
            if (target[i] == arr[i]) {
                continue;
            }
            int j = i + 1;
            while (j < n && (target[j] != arr[i] || used[j])) {
                j++;
            }
            if (j < n) {
                used[j] = true;
                result.add(j);
                result.add(i);
            } else {
                return new ArrayList<>();
            }
        }
        return result;
    }

    public List<Integer> minHammingDistance(int[] target, int[] arr) {
        int n = target.length;
        Map<Integer, Deque<Integer>> map = new HashMap<>();
        for (int i = 0; i < n; i++) {
            map.putIfAbsent(arr[i], new ArrayDeque<>());
            map.get(arr[i]).add(i);
        }

        List<Integer> swaps = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            if (target[i] == arr[i]) {
                continue;
            }
            Deque<Integer> queue = map.get(target[i]);
            if (queue == null || queue.isEmpty()) {
                return new ArrayList<>();
            }
            int j = queue.poll();
            swaps.add(i);
            swaps.add(j);
            int temp = arr[i];
            arr[i] = arr[j];
            arr[j] = temp;
        }
        return swaps;
    }

    public List<Integer> minHammingDistanceAfterSwapOperations(int[] target, int[] arr) {
        int n = target.length;
        if (n != arr.length) {
            return new ArrayList<>();
        }
        List<Integer> result = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            if (target[i] == arr[i]) {
                continue;
            }
            int j = i + 1;
            while (j < n && (arr[j] != target[i] || arr[j] == target[j])) {
                j++;
            }
            if (j < n) {
                result.add(i);
                result.add(j);
                int temp = arr[i];
                arr[i] = arr[j];
                arr[j] = temp;
            } else {
                return new ArrayList<>();
            }
        }
        return result;
    }
}
}