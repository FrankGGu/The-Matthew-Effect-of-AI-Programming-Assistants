class Solution {
    public int minTimeToType(String word) {
        int time = word.length(); 
        int currentPosition = 0;

        for (char c : word.toCharArray()) {
            int targetPosition = c - 'a';
            int distance = Math.abs(targetPosition - currentPosition);
            time += Math.min(distance, 26 - distance);
            currentPosition = targetPosition;
        }

        return time;
    }
}