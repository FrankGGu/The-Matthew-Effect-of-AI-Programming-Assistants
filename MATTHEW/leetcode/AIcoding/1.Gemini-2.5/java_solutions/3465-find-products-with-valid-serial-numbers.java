import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

class Solution {
    public List<List<String>> findValidProducts(List<List<String>> productsData) {
        if (productsData == null || productsData.isEmpty()) {
            return new ArrayList<>();
        }

        return productsData.stream()
                           .filter(this::isValidProductEntry)
                           .collect(Collectors.toList());
    }

    private boolean isValidProductEntry(List<String> productEntry) {
        if (productEntry == null || productEntry.size() < 2) {
            return false;
        }

        String serialNumber = productEntry.get(1);

        if (serialNumber == null || serialNumber.trim().isEmpty()) {
            return false;
        }

        String trimmedSn = serialNumber.trim();
        return trimmedSn.startsWith("SN") && trimmedSn.length() >= 7;
    }
}