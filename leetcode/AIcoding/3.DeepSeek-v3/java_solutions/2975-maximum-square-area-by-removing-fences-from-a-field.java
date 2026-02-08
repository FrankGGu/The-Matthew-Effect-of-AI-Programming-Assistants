class Solution {
    public int maximizeSquareArea(int m, int n, int[] hFences, int[] vFences) {
        Set<Integer> hSet = new HashSet<>();
        Set<Integer> vSet = new HashSet<>();

        hSet.add(1);
        hSet.add(m);
        for (int h : hFences) {
            hSet.add(h);
        }

        vSet.add(1);
        vSet.add(n);
        for (int v : vFences) {
            vSet.add(v);
        }

        List<Integer> hList = new ArrayList<>(hSet);
        List<Integer> vList = new ArrayList<>(vSet);
        Collections.sort(hList);
        Collections.sort(vList);

        int maxSide = 0;
        for (int i = 0; i < hList.size(); i++) {
            for (int j = i + 1; j < hList.size(); j++) {
                int side = hList.get(j) - hList.get(i);
                if (hasSide(vList, side)) {
                    maxSide = Math.max(maxSide, side);
                }
            }
        }

        return maxSide == 0 ? -1 : (int)(((long)maxSide * maxSide) % 1_000_000_007);
    }

    private boolean hasSide(List<Integer> list, int side) {
        for (int i = 0; i < list.size(); i++) {
            for (int j = i + 1; j < list.size(); j++) {
                if (list.get(j) - list.get(i) == side) {
                    return true;
                }
            }
        }
        return false;
    }
}