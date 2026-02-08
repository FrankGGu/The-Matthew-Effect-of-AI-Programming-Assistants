import java.util.HashSet;
import java.util.Set;

class DataStream {
    private Set<Integer> seen;
    private int value;
    private int k;

    public DataStream(int value, int k) {
        this.seen = new HashSet<>();
        this.value = value;
        this.k = k;
    }

    public boolean consec(int num) {
        if (num == value) {
            seen.add(num);
            if (seen.size() >= k) {
                return true;
            }
        } else {
            seen.clear();
        }
        return false;
    }
}