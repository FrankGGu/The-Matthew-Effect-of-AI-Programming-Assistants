class Solution {
    public int[] findPeaks(int[] mountain) {
        List<Integer> peaks = new ArrayList<>();
        for (int i = 1; i < mountain.length - 1; i++) {
            if (mountain[i] > mountain[i - 1] && mountain[i] > mountain[i + 1]) {
                peaks.add(i);
            }
        }
        int[] result = new int[peaks.size()];
        for (int i = 0; i < peaks.size(); i++) {
            result[i] = peaks.get(i);
        }
        return result;
    }
}