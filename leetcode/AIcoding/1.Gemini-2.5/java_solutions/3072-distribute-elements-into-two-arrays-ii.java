import java.util.*;

class FenwickTree {
    int[] bit;
    int size;

    public FenwickTree(int size) {
        this.size = size;
        bit = new int[size + 1]; // 1-indexed
    }

    public void update(int index, int delta) {
        index++; // Convert to 1-indexed
        while (index <= size) {
            bit[index] += delta;
            index += index & (-index);
        }
    }

    public int query(int index) {
        index++; // Convert to 1-indexed
        int sum = 0;
        while (index > 0) {
            sum += bit[index];
            index -= index & (-index);
        }
        return sum;
    }

    public int totalCount() {
        return query(size - 1);
    }
}

class Solution {
    public int[] resultArray(int[] nums) {
        int n = nums.length;

        Set<Integer> uniqueElements = new TreeSet<>();
        for (int num : nums) {
            uniqueElements.add(num);
        }

        Map<Integer, Integer> valToRank = new HashMap<>();
        int rank = 0;
        for (int num : uniqueElements) {
            valToRank.put(num, rank++);
        }
        int M = uniqueElements.size();

        List<Integer> arr1 = new ArrayList<>();
        List<Integer> arr2 = new ArrayList<>();

        FenwickTree ft1 = new FenwickTree(M);
        FenwickTree ft2 = new FenwickTree(M);

        arr1.add(nums[0]);
        ft1.update(valToRank.get(nums[0]), 1);

        arr2.add(nums[1]);
        ft2.update(valToRank.get(nums[1]), 1);

        for (int i = 2; i < n; i++) {
            int val = nums[i];
            int currentRank = valToRank.get(val);

            int countGreater1 = ft1.totalCount() - ft1.query(currentRank);
            int countGreater2 = ft2.totalCount() - ft2.query(currentRank);

            if (countGreater1 > countGreater2) {
                arr1.add(val);
                ft1.update(currentRank, 1);
            } else if (countGreater2 > countGreater1) {
                arr2.add(val);
                ft2.update(currentRank, 1);
            } else {
                arr1.add(val);
                ft1.update(currentRank, 1);
            }
        }

        int[] result = new int[n];
        int k = 0;
        for (int num : arr1) {
            result[k++] = num;
        }
        for (int num : arr2) {
            result[k++] = num;
        }

        return result;
    }
}