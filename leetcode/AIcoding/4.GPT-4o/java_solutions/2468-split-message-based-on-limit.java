class Solution {
    public List<String> splitMessage(String message, int limit) {
        List<String> result = new ArrayList<>();
        int n = message.length();
        int part = 1;

        while (true) {
            String partMessage = message.substring(0, Math.min(n, limit - String.valueOf(part).length() - 3));
            if (partMessage.length() + String.valueOf(part).length() + 3 > limit) {
                break;
            }
            result.add(partMessage + "(" + part + "/" + (n / partMessage.length() + (n % partMessage.length() == 0 ? 0 : 1)) + ")");
            if (partMessage.length() >= n) {
                break;
            }
            message = message.substring(partMessage.length());
            part++;
        }

        return result;
    }
}