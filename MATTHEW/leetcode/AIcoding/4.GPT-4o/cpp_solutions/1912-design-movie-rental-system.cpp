class MovieRentalSystem {
public:
    MovieRentalSystem(vector<vector<int>>& movies) {
        for (const auto& movie : movies) {
            movieMap[movie[0]].emplace_back(movie[1], movie[2]);
        }
    }

    vector<int> rent(int movieId, int num) {
        if (movieMap.find(movieId) == movieMap.end()) return {};
        auto& rentals = movieMap[movieId];
        vector<int> result;
        int total = 0;
        for (auto& rental : rentals) {
            if (rental.second > 0) {
                int rentCount = min(rental.second, num - total);
                result.push_back(rental.first);
                total += rentCount;
                rental.second -= rentCount;
                if (total == num) break;
            }
        }
        if (total < num) return {};
        return result;
    }

    void returnMovie(int movieId, vector<int>& movieIds) {
        for (int id : movieIds) {
            movieMap[movieId].emplace_back(id, 1);
        }
    }

private:
    unordered_map<int, vector<pair<int, int>>> movieMap;
};