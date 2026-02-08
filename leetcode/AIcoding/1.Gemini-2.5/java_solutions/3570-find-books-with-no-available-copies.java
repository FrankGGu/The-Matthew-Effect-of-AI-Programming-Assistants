import java.time.LocalDate;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

class Solution {
    public List<String> findBooksWithNoAvailableCopies(List<Book> books, List<Order> orders) {
        LocalDate targetAvailabilityDate = LocalDate.of(2019, 6, 23);
        LocalDate orderPeriodStart = LocalDate.of(2018, 6, 23);
        LocalDate orderPeriodEnd = LocalDate.of(2019, 6, 23);

        Set<Integer> orderedBookIdsInLastYear = orders.stream()
            .filter(order -> !order.dispatch_date.isBefore(orderPeriodStart) && order.dispatch_date.isBefore(orderPeriodEnd))
            .map(order -> order.book_id)
            .collect(Collectors.toSet());

        List<String> resultTitles = new ArrayList<>();
        for (Book book : books) {
            boolean isAvailableBeforeTargetDate = book.available_from.isBefore(targetAvailabilityDate);
            boolean notOrderedInLastYear = !orderedBookIdsInLastYear.contains(book.book_id);

            if (isAvailableBeforeTargetDate && notOrderedInLastYear) {
                resultTitles.add(book.title);
            }
        }

        return resultTitles;
    }
}