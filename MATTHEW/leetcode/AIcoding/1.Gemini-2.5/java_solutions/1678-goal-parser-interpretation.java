class Solution {
    public String interpret(String command) {
        String s1 = command.replace("(al)", "al");
        String s2 = s1.replace("()", "o");
        return s2;
    }
}