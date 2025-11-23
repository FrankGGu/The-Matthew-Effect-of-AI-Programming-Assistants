import java.util.*;

class MovieRental {
    private Map<Integer, Integer> inventory;
    private Map<Integer, List<Integer>> customerRentals;
    private PriorityQueue<int[]> availableMovies;
    private Map<Integer, Integer> movieToStock;

    public MovieRental(int[][] movieInfo) {
        inventory = new HashMap<>();
        customerRentals = new HashMap<>();
        movieToStock = new HashMap<>();
        availableMovies = new PriorityQueue<>((a, b) -> a[1] - b[1]);

        for (int[] movie : movieInfo) {
            int movieId = movie[0];
            int count = movie[1];
            inventory.put(movieId, count);
            movieToStock.put(movieId, count);
            availableMovies.offer(new int[]{movieId, count});
        }
    }

    public List<Integer> rent(int customerId, int numMovies) {
        List<Integer> rentedMovies = new ArrayList<>();
        while (numMovies > 0 && !availableMovies.isEmpty()) {
            int[] movie = availableMovies.poll();
            int movieId = movie[0];
            int stock = movie[1];
            if (stock > 0) {
                rentedMovies.add(movieId);
                customerRentals.putIfAbsent(customerId, new ArrayList<>());
                customerRentals.get(customerId).add(movieId);
                inventory.put(movieId, stock - 1);
                if (stock - 1 > 0) {
                    availableMovies.offer(new int[]{movieId, stock - 1});
                }
                numMovies--;
            }
        }
        return rentedMovies;
    }

    public void returnMovie(int customerId, int movieId) {
        if (customerRentals.containsKey(customerId) && customerRentals.get(customerId).remove(Integer.valueOf(movieId))) {
            int stock = inventory.getOrDefault(movieId, 0);
            inventory.put(movieId, stock + 1);
            availableMovies.offer(new int[]{movieId, stock + 1});
        }
    }

    public List<Integer> getRentedMovies(int customerId) {
        return customerRentals.getOrDefault(customerId, new ArrayList<>());
    }
}