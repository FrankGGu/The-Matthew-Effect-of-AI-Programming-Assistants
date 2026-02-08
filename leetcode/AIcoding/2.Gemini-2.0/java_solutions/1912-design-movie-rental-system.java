import java.util.*;

class MovieRentingSystem {

    private Map<Integer, Map<Integer, Integer>> movies;
    private PriorityQueue<int[]> rentedMovies;
    private Map<Integer, Set<Integer>> shopMovies;

    public MovieRentingSystem(int n, int[][] entries) {
        movies = new HashMap<>();
        rentedMovies = new PriorityQueue<>((a, b) -> {
            if (a[2] != b[2]) {
                return a[2] - b[2];
            }
            if (a[0] != b[0]) {
                return a[0] - b[0];
            }
            return a[1] - b[1];
        });
        shopMovies = new HashMap<>();

        for (int[] entry : entries) {
            int shop = entry[0];
            int movie = entry[1];
            int price = entry[2];

            movies.computeIfAbsent(movie, k -> new HashMap<>()).put(shop, price);
            shopMovies.computeIfAbsent(shop, k -> new HashSet<>()).add(movie);
        }
    }

    public List<Integer> search(int movie) {
        List<Integer> shops = new ArrayList<>();
        if (!movies.containsKey(movie)) {
            return shops;
        }

        PriorityQueue<Integer> pq = new PriorityQueue<>();
        for (int shop : movies.get(movie).keySet()) {
            pq.offer(shop);
        }

        int count = 0;
        while (!pq.isEmpty() && count < 5) {
            shops.add(pq.poll());
            count++;
        }

        return shops;
    }

    public void rent(int shop, int movie) {
        int price = movies.get(movie).get(shop);
        rentedMovies.offer(new int[]{shop, movie, price});
        shopMovies.get(shop).remove(movie);
    }

    public void drop(int shop, int movie) {
        int price = movies.get(movie).get(shop);
        shopMovies.get(shop).add(movie);
    }

    public List<List<Integer>> report() {
        List<List<Integer>> report = new ArrayList<>();
        PriorityQueue<int[]> temp = new PriorityQueue<>((a, b) -> {
            if (a[2] != b[2]) {
                return a[2] - b[2];
            }
            if (a[0] != b[0]) {
                return a[0] - b[0];
            }
            return a[1] - b[1];
        });

        int count = 0;
        while (!rentedMovies.isEmpty() && count < 5) {
            int[] movie = rentedMovies.poll();
            temp.offer(movie);
            report.add(Arrays.asList(movie[0], movie[1]));
            count++;
        }

        while (!temp.isEmpty()) {
            rentedMovies.offer(temp.poll());
        }

        return report;
    }
}