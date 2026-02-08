public class Solution {
    public boolean isSubstringInReverse(String s, String sub) {
        StringBuilder reversed = new StringBuilder(s).reverse();
        return reversed.toString().contains(sub);
    }
}