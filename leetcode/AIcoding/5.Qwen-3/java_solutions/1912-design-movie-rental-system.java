public class Solution {

import java.util.*;

class MovieRentalSystem {
    private Map<Integer, List<int[]>> movieMap;
    private Map<Integer, Set<Integer>> userMap;
    private Set<Integer> rentedMovies;
    private PriorityQueue<int[]> availableMovies;

    public MovieRentalSystem(int n, int[][] entries) {
        movieMap = new HashMap<>();
        userMap = new HashMap<>();
        rentedMovies = new HashSet<>();
        availableMovies = new PriorityQueue<>((a, b) -> a[0] != b[0] ? a[0] - b[0] : a[1] - b[1]);

        for (int[] entry : entries) {
            int userId = entry[0];
            int movieId = entry[1];
            int price = entry[2];
            if (!movieMap.containsKey(movieId)) {
                movieMap.put(movieId, new ArrayList<>());
            }
            movieMap.get(movieId).add(new int[]{userId, price});
            if (!userMap.containsKey(userId)) {
                userMap.put(userId, new HashSet<>());
            }
            userMap.get(userId).add(movieId);
            availableMovies.offer(new int[]{price, movieId});
        }
    }

    public List<Integer> search(int movieId) {
        List<Integer> result = new ArrayList<>();
        if (!movieMap.containsKey(movieId)) {
            return result;
        }
        for (int[] entry : movieMap.get(movieId)) {
            if (!rentedMovies.contains(entry[1])) {
                result.add(entry[0]);
            }
        }
        return result;
    }

    public int rent(int userId, int movieId) {
        if (!userMap.containsKey(userId) || !userMap.get(userId).contains(movieId)) {
            return -1;
        }
        if (rentedMovies.contains(movieId)) {
            return -1;
        }
        rentedMovies.add(movieId);
        return 0;
    }

    public int drop(int userId, int movieId) {
        if (!userMap.containsKey(userId) || !userMap.get(userId).contains(movieId)) {
            return -1;
        }
        if (!rentedMovies.contains(movieId)) {
            return -1;
        }
        rentedMovies.remove(movieId);
        return 0;
    }

    public List<int[]> report() {
        List<int[]> result = new ArrayList<>();
        while (!availableMovies.isEmpty()) {
            int[] current = availableMovies.poll();
            if (rentedMovies.contains(current[1])) {
                result.add(new int[]{current[0], current[1]});
            }
        }
        return result;
    }
}
}