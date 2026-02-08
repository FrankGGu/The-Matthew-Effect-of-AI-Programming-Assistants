import java.util.Random;

class Solution extends Random {
    public int rand10() {
        int num = 40;
        while (num >= 40) {
            num = 7 * rand7() + rand7() - 8;
        }
        return num % 10 + 1;
    }

    public int rand7() {
        return super.nextInt(7) + 1;
    }
}