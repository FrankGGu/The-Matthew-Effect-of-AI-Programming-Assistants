public class DeepDarkFraction {

    public int[] fraction(int[] cont) {
        int a = 1, b = cont[cont.length - 1];
        for (int i = cont.length - 2; i >= 0; i--) {
            int temp = a;
            a = b;
            b = cont[i] * b + temp;
        }
        return new int[]{b, a};
    }
}