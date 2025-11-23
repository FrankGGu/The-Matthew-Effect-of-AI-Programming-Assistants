import java.util.*;

class Solution {

    private static class Complex {
        double real;
        double imag;

        public Complex(double real, double imag) {
            this.real = real;
            this.imag = imag;
        }

        public Complex add(Complex other) {
            return new Complex(this.real + other.real, this.imag + other.imag);
        }

        public Complex subtract(Complex other) {
            return new Complex(this.real - other.real, this.imag - other.imag);
        }

        public Complex multiply(Complex other) {
            return new Complex(this.real * other.real - this.imag * other.imag,
                               this.real * other.imag + this.imag * other.real);
        }
    }

    private static void fft(Complex[] a, boolean invert) {
        int n = a.length;

        for (int i = 1, j = 0; i < n; i++) {
            int bit = n >> 1;
            for (; j >= bit; bit >>= 1) {
                j -= bit;
            }
            j += bit;
            if (i < j) {
                Complex temp = a[i];
                a[i] = a[j];
                a[j] = temp;
            }
        }

        for (int len = 2; len <= n; len <<= 1) {
            double ang = 2 * Math.PI / len * (invert ? -1 : 1);
            Complex wlen = new Complex(Math.cos(ang), Math.sin(ang));
            for (int i = 0; i < n; i += len) {
                Complex w = new Complex(1, 0);
                for (int j = 0; j < len / 2; j++) {
                    Complex u = a[i + j];
                    Complex v = a[i + j + len / 2].multiply(w);
                    a[i + j] = u.add(v);
                    a[i + j + len / 2] = u.subtract(v);
                    w = w.multiply(wlen);
                }
            }
        }

        if (invert) {
            for (int i = 0; i < n; i++) {
                a[i].real /= n;
                a[i].imag /= n;
            }
        }
    }

    private static class SweepEvent {
        int point;
        int type; // 1 for start of edge adjustment interval (+1), 0 for query, -1 for end of edge adjustment interval (-1)
        int value; // +1 or -1 for edge adjustment, original_index for query

        public SweepEvent(int point, int type, int value) {
            this.point = point;
            this.type = type;
            this.value = value;
        }
    }

    public int[] countPairsOfNodes(int n, int[][] edges, int[] queries) {
        int[] deg = new int[n + 1];
        Map<Long, Integer> edgeCountsMap = new HashMap<>();

        for (int[] edge : edges) {
            int u = edge[0];
            int v = edge[1];
            deg[u]++;
            deg[v]++;

            int node1 = Math.min(u, v);
            int node2 = Math.max(u, v);
            long key = (long) node1 * (n + 1) + node2;
            edgeCountsMap.put(key, edgeCountsMap.getOrDefault(key, 0) + 1);
        }

        int[] freq = new int[n + 1]; // freq[d] = count of nodes with degree d
        for (int i = 1; i <= n; i++) {
            freq[deg[i]]++;
        }

        int maxPossibleDegree = n - 1;
        int maxDegreeSum = 2 * maxPossibleDegree;
        int fftSize = 1;
        while (fftSize <= maxDegreeSum) {
            fftSize <<= 1;
        }

        Complex[] poly = new Complex[fftSize];
        for (int i = 0; i < fftSize; i++) {
            poly[i] = new Complex(0, 0);
        }
        for (int i = 0; i <= maxPossibleDegree; i++) {
            poly[i] = new Complex(freq[i], 0);
        }

        fft(poly, false);
        for (int i = 0; i < fftSize; i++) {
            poly[i] = poly[i].multiply(poly[i]);
        }
        fft(poly, true);

        int[] pairSumFreq = new int[maxDegreeSum + 1];
        for (int s = 0; s <= maxDegreeSum; s++) {
            pairSumFreq[s] = (int) Math.round(poly[s].real);
        }

        for (int s = 0; s <= maxDegreeSum; s++) {
            if (s % 2 == 0 && s / 2 <= maxPossibleDegree) {
                pairSumFreq[s] -= freq[s / 2];
            }
            pairSumFreq[s] /= 2;
        }

        int[] suffixSumPairFreq = new int[maxDegreeSum + 2];
        for (int s = maxDegreeSum; s >= 0; s--) {
            suffixSumPairFreq[s] = pairSumFreq[s] + suffixSumPairFreq[s + 1];
        }

        List<SweepEvent> sweepEvents = new ArrayList<>();
        for (int i = 0; i < queries.length; i++) {
            sweepEvents.add(new SweepEvent(queries[i], 0, i)); // type 0 for query
        }

        for (Map.Entry<Long, Integer> entry : edgeCountsMap.entrySet()) {
            long key = entry.getKey();
            int k = entry.getValue();
            int node1 = (int) (key / (n + 1));
            int node2 = (int) (key % (n + 1));
            int valSum = deg[node1] + deg[node2];

            int L_q = valSum - k;
            int R_q = valSum - 1;

            L_q = Math.max(0, L_q);

            sweepEvents.add(new SweepEvent(L_q, 1, 1)); // type 1 for start of adjustment interval (+1)
            sweepEvents.add(new SweepEvent(R_q + 1, -1, -1)); // type -1 for end of adjustment interval (-1)
        }

        Collections.sort(sweepEvents, (a, b) -> {
            if (a.point != b.point) {
                return Integer.compare(a.point, b.point);
            }
            return Integer.compare(b.type, a.type); // Process type 1 (start) then 0 (query) then -1 (end)
        });

        int[] ans = new int[queries.length];
        int currentAdjustment = 0;
        for (SweepEvent event : sweepEvents) {
            if (event.type == 1 || event.type == -1) { // Start or end of adjustment interval
                currentAdjustment += event.value;
            } else { // Query event
                int q = event.point;
                int originalIndex = event.value;
                int initialCount = (q + 1 <= maxDegreeSum) ? suffixSumPairFreq[q + 1] : 0;
                ans[originalIndex] = initialCount - currentAdjustment;
            }
        }

        return ans;
    }
}