class MovieRentingSystem {
    private Map<Integer, Map<Integer, Integer>> movieToShopPrice;
    private Map<Integer, TreeSet<int[]>> movieToAvailable;
    private TreeSet<int[]> rented;
    private Map<Integer, Map<Integer, Entry>> shopMovieToEntry;

    public MovieRentingSystem(int n, int[][] entries) {
        movieToShopPrice = new HashMap<>();
        movieToAvailable = new HashMap<>();
        rented = new TreeSet<>((a, b) -> {
            if (a[2] != b[2]) return a[2] - b[2];
            if (a[0] != b[0]) return a[0] - b[0];
            return a[1] - b[1];
        });
        shopMovieToEntry = new HashMap<>();

        for (int[] entry : entries) {
            int shop = entry[0];
            int movie = entry[1];
            int price = entry[2];
            movieToShopPrice.computeIfAbsent(movie, k -> new HashMap<>()).put(shop, price);
            movieToAvailable.computeIfAbsent(movie, k -> new TreeSet<>((a, b) -> {
                if (a[1] != b[1]) return a[1] - b[1];
                return a[0] - b[0];
            })).add(new int[]{shop, price});
            shopMovieToEntry.computeIfAbsent(shop, k -> new HashMap<>()).put(movie, new Entry(shop, movie, price));
        }
    }

    public List<Integer> search(int movie) {
        List<Integer> result = new ArrayList<>();
        if (!movieToAvailable.containsKey(movie)) return result;
        TreeSet<int[]> available = movieToAvailable.get(movie);
        for (int[] entry : available) {
            if (result.size() >= 5) break;
            result.add(entry[0]);
        }
        return result;
    }

    public void rent(int shop, int movie) {
        int price = movieToShopPrice.get(movie).get(shop);
        movieToAvailable.get(movie).remove(new int[]{shop, price});
        rented.add(new int[]{shop, movie, price});
    }

    public void drop(int shop, int movie) {
        int price = movieToShopPrice.get(movie).get(shop);
        movieToAvailable.get(movie).add(new int[]{shop, price});
        rented.remove(new int[]{shop, movie, price});
    }

    public List<List<Integer>> report() {
        List<List<Integer>> result = new ArrayList<>();
        for (int[] entry : rented) {
            if (result.size() >= 5) break;
            result.add(Arrays.asList(entry[0], entry[1]));
        }
        return result;
    }

    private static class Entry {
        int shop;
        int movie;
        int price;

        Entry(int shop, int movie, int price) {
            this.shop = shop;
            this.movie = movie;
            this.price = price;
        }
    }
}