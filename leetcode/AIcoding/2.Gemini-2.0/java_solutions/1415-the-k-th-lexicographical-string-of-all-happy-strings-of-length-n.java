class Solution {
    int count = 0;
    String result = "";

    public String getHappyString(int n, int k) {
        generate("", n, k);
        return result;
    }

    private void generate(String current, int n, int k) {
        if (count >= k) {
            return;
        }

        if (current.length() == n) {
            count++;
            if (count == k) {
                result = current;
            }
            return;
        }

        char lastChar = current.isEmpty() ? ' ' : current.charAt(current.length() - 1);

        if (lastChar != 'a') {
            generate(current + "a", n, k);
        }
        if (lastChar != 'b') {
            generate(current + "b", n, k);
        }
        if (lastChar != 'c') {
            generate(current + "c", n, k);
        }
    }
}