class Solution {
    public String complexNumberMultiply(String a, String b) {
        String[] partsA = a.split("\\+");
        String[] partsB = b.split("\\+");
        int realA = Integer.parseInt(partsA[0]);
        int imagA = Integer.parseInt(partsA[1].replace("i", ""));
        int realB = Integer.parseInt(partsB[0]);
        int imagB = Integer.parseInt(partsB[1].replace("i", ""));

        int realResult = realA * realB - imagA * imagB;
        int imagResult = realA * imagB + imagA * realB;

        return realResult + "+" + imagResult + "i";
    }
}