import java.util.PriorityQueue;
import java.util.Collections;

class SequentiallyOrdinalRankTracker {

    private static class City implements Comparable<City> {
        String name;
        int score;

        public City(String name, int score) {
            this.name = name;
            this.score = score;
        }

        @Override
        public int compareTo(City other) {
            // Higher score is better
            if (this.score != other.score) {
                return Integer.compare(other.score, this.score);
            }
            // If scores are tied, lexicographically smaller name is better
            return this.name.compareTo(other.name);
        }
    }

    // minHeap stores the 'getCount' best cities. Its root is the getCount-th best city.
    // (Natural ordering: smaller/worse elements are at the top)
    private PriorityQueue<City> minHeap; 

    // maxHeap stores the remaining cities. Its root is the (getCount+1)-th best city.
    // (Reverse ordering: larger/better elements are at the top)
    private PriorityQueue<City> maxHeap;

    private int getCount;

    public SequentiallyOrdinalRankTracker() {
        minHeap = new PriorityQueue<>();
        maxHeap = new PriorityQueue<>(Collections.reverseOrder());
        getCount = 0;
    }

    public void add(String name, int score) {
        City newCity = new City(name, score);

        // Add the new city to maxHeap first (initially considered not among the top 'getCount')
        maxHeap.offer(newCity);

        // Move the best city from maxHeap to minHeap to maintain the top 'getCount' elements
        minHeap.offer(maxHeap.poll());

        // Balance: If minHeap has more than 'getCount' elements, move the worst one back to maxHeap
        if (minHeap.size() > getCount) {
            maxHeap.offer(minHeap.poll());
        }
    }

    public String get() {
        // Increment the rank we are looking for
        getCount++;

        // Move the best city from maxHeap to minHeap to include it in the top 'getCount'
        // This makes the root of minHeap the new getCount-th best element
        minHeap.offer(maxHeap.poll());

        // The root of minHeap is now the getCount-th best city
        return minHeap.peek().name;
    }
}