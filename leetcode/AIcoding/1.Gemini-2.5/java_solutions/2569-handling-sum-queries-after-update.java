import java.util.ArrayList;
import java.util.List;

class Solution {

    private static class Node {
        long sumZero;
        long sumOne;
        int countZero;
        int countOne;
        boolean lazyFlip;

        Node() {
            sumZero = 0;
            sumOne = 0;
            countZero = 0;
            countOne = 0;
            lazyFlip = false;
        }
    }

    private Node[] nodes;
    private int N;
    private long[] currentNums2;

    public long[] handleQuery(int[] nums1, int[] nums2, int[][] queries) {
        N = nums1.length;
        nodes = new Node[4 * N];
        for (int i = 0; i < 4 * N; i++) {
            nodes[i] = new Node();
        }

        currentNums2 = new long[N];
        for (int i = 0; i < N; i++) {
            currentNums2[i] = nums2[i];
        }

        build(0, 0, N - 1, nums1, currentNums2);

        List<Long> results = new ArrayList<>();
        for (int[] query : queries) {
            if (query[0] == 0) {
                updateFlip(0, 0, N - 1, query[1], query[2]);
            } else if (query[0] == 1) {
                results.add(querySumOne(0, 0, N - 1, query[1], query[2]));
            } else { // query[0] == 2
                updateValue(0, 0, N - 1, query[1], query[2]);
            }
        }

        long[] finalResults = new long[results.size()];
        for (int i = 0; i < results.size(); i++) {
            finalResults[i] = results.get(i);
        }
        return finalResults;
    }

    private void build(int idx, int lo, int hi, int[] nums1, long[] nums2) {
        if (lo == hi) {
            if (nums1[lo] == 0) {
                nodes[idx].sumZero = nums2[lo];
                nodes[idx].countZero = 1;
            } else { // nums1[lo] == 1
                nodes[idx].sumOne = nums2[lo];
                nodes[idx].countOne = 1;
            }
            return;
        }

        int mid = lo + (hi - lo) / 2;
        build(2 * idx + 1, lo, mid, nums1, nums2);
        build(2 * idx + 2, mid + 1, hi, nums1, nums2);

        nodes[idx].sumZero = nodes[2 * idx + 1].sumZero + nodes[2 * idx + 2].sumZero;
        nodes[idx].sumOne = nodes[2 * idx + 1].sumOne + nodes[2 * idx + 2].sumOne;
        nodes[idx].countZero = nodes[2 * idx + 1].countZero + nodes[2 * idx + 2].countZero;
        nodes[idx].countOne = nodes[2 * idx + 1].countOne + nodes[2 * idx + 2].countOne;
    }

    private void pushDown(int idx) {
        if (nodes[idx].lazyFlip) {
            Node leftChild = nodes[2 * idx + 1];
            Node rightChild = nodes[2 * idx + 2];

            long tempSum = leftChild.sumZero;
            leftChild.sumZero = leftChild.sumOne;
            leftChild.sumOne = tempSum;
            int tempCount = leftChild.countZero;
            leftChild.countZero = leftChild.countOne;
            leftChild.countOne = tempCount;
            leftChild.lazyFlip = !leftChild.lazyFlip;

            tempSum = rightChild.sumZero;
            rightChild.sumZero = rightChild.sumOne;
            rightChild.sumOne = tempSum;
            tempCount = rightChild.countZero;
            rightChild.countZero = rightChild.countOne;
            rightChild.countOne = tempCount;
            rightChild.lazyFlip = !rightChild.lazyFlip;

            nodes[idx].lazyFlip = false;
        }
    }

    private void updateFlip(int idx, int lo, int hi, int queryL, int queryR) {
        if (queryL <= lo && hi <= queryR) {
            long tempSum = nodes[idx].sumZero;
            nodes[idx].sumZero = nodes[idx].sumOne;
            nodes[idx].sumOne = tempSum;
            int tempCount = nodes[idx].countZero;
            nodes[idx].countZero = nodes[idx].countOne;
            nodes[idx].countOne = tempCount;
            nodes[idx].lazyFlip = !nodes[idx].lazyFlip;
            return;
        }

        if (hi < queryL || lo > queryR) {
            return;
        }

        pushDown(idx);

        int mid = lo + (hi - lo) / 2;
        updateFlip(2 * idx + 1, lo, mid, queryL, queryR);
        updateFlip(2 * idx + 2, mid + 1, hi, queryL, queryR);

        nodes[idx].sumZero = nodes[2 * idx + 1].sumZero + nodes[2 * idx + 2].sumZero;
        nodes[idx].sumOne = nodes[2 * idx + 1].sumOne + nodes[2 * idx + 2].sumOne;
        nodes[idx].countZero = nodes[2 * idx + 1].countZero + nodes[2 * idx + 2].countZero;
        nodes[idx].countOne = nodes[2 * idx + 1].countOne + nodes[2 * idx + 2].countOne;
    }

    private void updateValue(int idx, int lo, int hi, int targetIdx, int newNum2Value) {
        if (lo == hi) {
            if (nodes[idx].countZero == 1) {
                nodes[idx].sumZero = newNum2Value;
            } else {
                nodes[idx].sumOne = newNum2Value;
            }
            currentNums2[targetIdx] = newNum2Value;
            return;
        }

        pushDown(idx);

        int mid = lo + (hi - lo) / 2;
        if (targetIdx <= mid) {
            updateValue(2 * idx + 1, lo, mid, targetIdx, newNum2Value);
        } else {
            updateValue(2 * idx + 2, mid + 1, hi, targetIdx, newNum2Value);
        }

        nodes[idx].sumZero = nodes[2 * idx + 1].sumZero + nodes[2 * idx + 2].sumZero;
        nodes[idx].sumOne = nodes[2 * idx + 1].sumOne + nodes[2 * idx + 2].sumOne;
        nodes[idx].countZero = nodes[2 * idx + 1].countZero + nodes[2 * idx + 2].countZero;
        nodes[idx].countOne = nodes[2 * idx + 1].countOne + nodes[2 * idx + 2].countOne;
    }

    private long querySumOne(int idx, int lo, int hi, int queryL, int queryR) {
        if (queryL <= lo && hi <= queryR) {
            return nodes[idx].sumOne;
        }

        if (hi < queryL || lo > queryR) {
            return 0L;
        }

        pushDown(idx);

        int mid = lo + (hi - lo) / 2;
        long leftSum = querySumOne(2 * idx + 1, lo, mid, queryL, queryR);
        long rightSum = querySumOne(2 * idx + 2, mid + 1, hi, queryL, queryR);
        return leftSum + rightSum;
    }
}