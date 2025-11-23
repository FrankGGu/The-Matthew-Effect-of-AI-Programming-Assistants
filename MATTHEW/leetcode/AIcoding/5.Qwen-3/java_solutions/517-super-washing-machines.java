public class Solution {
    public int superWashingMachines(int[] machines) {
        int total = 0;
        for (int machine : machines) {
            total += machine;
        }
        if (total % machines.length != 0) {
            return -1;
        }
        int avg = total / machines.length;
        int result = 0;
        int balance = 0;
        for (int i = 0; i < machines.length; i++) {
            balance += machines[i] - avg;
            result = Math.max(result, Math.abs(balance));
        }
        return result;
    }
}