import java.time.LocalDate;
import java.util.List;
import java.util.Map;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.stream.Collectors;

class Solution {

    public static class Sale {
        public int saleId;
        public int productId;
        public LocalDate saleDate;
        public double amount;

        public Sale(int saleId, int productId, LocalDate saleDate, double amount) {
            this.saleId = saleId;
            this.productId = productId;
            this.saleDate = saleDate;
            this.amount = amount;
        }

        public int getProductId() { return productId; }
        public LocalDate getSaleDate() { return saleDate; }
        public double getAmount() { return amount; }
    }

    public static class Product {
        public int productId;
        public String productName;

        public Product(int productId, String productName) {
            this.productId = productId;
            this.productName = productName;
        }

        public int getProductId() { return productId; }
        public String getProductName() { return productName; }
    }

    public static class ProductSeasonalSales {
        public int productId;
        public String productName;
        public String season;
        public double totalSales;

        public ProductSeasonalSales(int productId, String productName, String season, double totalSales) {
            this.productId = productId;
            this.productName = productName;
            this.season = season;
            this.totalSales = totalSales;
        }

        public int getProductId() { return productId; }
        public String getProductName() { return productName; }
        public String getSeason() { return season; }
        public double getTotalSales() { return totalSales; }
    }

    public List<ProductSeasonalSales> analyze(List<Sale> sales, List<Product> products) {
        Map<Integer, String> productNames = products.stream()
                .collect(Collectors.toMap(Product::getProductId, Product::getProductName));

        Map<Integer, Map<String, Double>> productSeasonSalesMap = new HashMap<>();

        for (Sale sale : sales) {
            int productId = sale.getProductId();
            LocalDate saleDate = sale.getSaleDate();
            double amount = sale.getAmount();

            String season = getSeason(saleDate);

            productSeasonSalesMap
                    .computeIfAbsent(productId, k -> new HashMap<>())
                    .merge(season, amount, Double::sum);
        }

        List<ProductSeasonalSales> result = new ArrayList<>();
        for (Map.Entry<Integer, Map<String, Double>> productEntry : productSeasonSalesMap.entrySet()) {
            int productId = productEntry.getKey();
            String productName = productNames.getOrDefault(productId, "Unknown Product");

            for (Map.Entry<String, Double> seasonEntry : productEntry.getValue().entrySet()) {
                String season = seasonEntry.getKey();
                double totalSales = seasonEntry.getValue();
                result.add(new ProductSeasonalSales(productId, productName, season, totalSales));
            }
        }

        return result;
    }

    private String getSeason(LocalDate date) {
        int month = date.getMonthValue();
        if (month >= 1 && month <= 3) {
            return "Q1";
        } else if (month >= 4 && month <= 6) {
            return "Q2";
        } else if (month >= 7 && month <= 9) {
            return "Q3";
        } else {
            return "Q4";
        }
    }
}