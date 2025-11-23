class Solution {
    public int guardSpaceCity(int[][] guards, int[][] walls) {
        Set<String> guardSet = new HashSet<>();
        for (int[] guard : guards) {
            guardSet.add(guard[0] + "," + guard[1]);
        }

        Set<String> wallSet = new HashSet<>();
        for (int[] wall : walls) {
            wallSet.add(wall[0] + "," + wall[1]);
        }

        int count = 0;
        for (int[] guard : guards) {
            int x = guard[0], y = guard[1];
            if (!wallSet.contains((x - 1) + "," + y) && !guardSet.contains((x - 1) + "," + y)) count++;
            if (!wallSet.contains((x + 1) + "," + y) && !guardSet.contains((x + 1) + "," + y)) count++;
            if (!wallSet.contains(x + "," + (y - 1)) && !guardSet.contains(x + "," + (y - 1))) count++;
            if (!wallSet.contains(x + "," + (y + 1)) && !guardSet.contains(x + "," + (y + 1))) count++;
        }

        return count;
    }
}