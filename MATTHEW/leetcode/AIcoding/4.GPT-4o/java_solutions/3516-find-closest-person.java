class Solution {
    public int findClosestPerson(int[] persons, int target) {
        int closestIndex = -1;
        int minDistance = Integer.MAX_VALUE;

        for (int i = 0; i < persons.length; i++) {
            if (persons[i] == target) {
                return i;
            }
            int distance = Math.abs(persons[i] - target);
            if (distance < minDistance) {
                minDistance = distance;
                closestIndex = i;
            }
        }

        return closestIndex;
    }
}