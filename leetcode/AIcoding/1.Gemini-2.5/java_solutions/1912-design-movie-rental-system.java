import java.util.*;

class MovieRentalSystem {

    private final int numShops;
    private final Map<Integer, Map<Integer, Integer>> originalMoviePrices; // shopId -> (movieId -> price)
    private final Map<Integer, Map<Integer, Integer>> availableMoviesByShop; // shopId -> (movieId -> price)
    private final TreeSet<RentalInfo> rentedMovies; // price, shopId, movieId

    public MovieRentalSystem(int n, int[][] entries) {
        this.numShops = n;
        this.originalMoviePrices = new HashMap<>();
        this.availableMoviesByShop = new HashMap<>();
        this.rentedMovies = new TreeSet<>();

        for (int[] entry : entries) {
            int shopId = entry[0];
            int movieId = entry[1];
            int price = entry[2];

            originalMoviePrices.computeIfAbsent(shopId, k -> new HashMap<>()).put(movieId, price);
            availableMoviesByShop.computeIfAbsent(shopId, k -> new HashMap<>()).put(movieId, price);
        }
    }

    public List<Integer> search(int movie) {
        List<ShopMoviePair> candidates = new ArrayList<>();
        for (int shopId = 0; shopId < numShops; shopId++) {
            Map<Integer, Integer> shopAvailable = availableMoviesByShop.get(shopId);
            if (shopAvailable != null && shopAvailable.containsKey(movie)) {
                candidates.add(new ShopMoviePair(shopAvailable.get(movie), shopId));
            }
        }
        Collections.sort(candidates);
        List<Integer> result = new ArrayList<>();
        for (int i = 0; i < Math.min(5, candidates.size()); i++) {
            result.add(candidates.get(i).shopId);
        }
        return result;
    }

    public void rent(int shop, int movie) {
        Map<Integer, Integer> shopAvailable = availableMoviesByShop.get(shop);
        int price = shopAvailable.remove(movie);
        rentedMovies.add(new RentalInfo(price, shop, movie));
    }

    public void drop(int shop, int movie) {
        int price = originalMoviePrices.get(shop).get(movie);
        rentedMovies.remove(new RentalInfo(price, shop, movie));
        availableMoviesByShop.computeIfAbsent(shop, k -> new HashMap<>()).put(movie, price);
    }

    public List<List<Integer>> report() {
        List<List<Integer>> result = new ArrayList<>();
        int count = 0;
        for (RentalInfo ri : rentedMovies) {
            if (count >= 5) {
                break;
            }
            result.add(Arrays.asList(ri.shopId, ri.movieId));
            count++;
        }
        return result;
    }

    private static class RentalInfo implements Comparable<RentalInfo> {
        int price;
        int shopId;
        int movieId;

        RentalInfo(int price, int shopId, int movieId) {
            this.price = price;
            this.shopId = shopId;
            this.movieId = movieId;
        }

        @Override
        public int compareTo(RentalInfo other) {
            if (this.price != other.price) {
                return Integer.compare(this.price, other.price);
            }
            if (this.shopId != other.shopId) {
                return Integer.compare(this.shopId, other.shopId);
            }
            return Integer.compare(this.movieId, other.movieId);
        }

        @Override
        public boolean equals(Object o) {
            if (this == o) return true;
            if (o == null || getClass() != o.getClass()) return false;
            RentalInfo that = (RentalInfo) o;
            return price == that.price && shopId == that.shopId && movieId == that.movieId;
        }

        @Override
        public int hashCode() {
            return Objects.hash(price, shopId, movieId);
        }
    }

    private static class ShopMoviePair implements Comparable<ShopMoviePair> {
        int price;
        int shopId;

        ShopMoviePair(int price, int shopId) {
            this.price = price;
            this.shopId = shopId;
        }

        @Override
        public int compareTo(ShopMoviePair other) {
            if (this.price != other.price) {
                return Integer.compare(this.price, other.price);
            }
            return Integer.compare(this.shopId, other.shopId);
        }
    }
}